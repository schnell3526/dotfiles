// カーソルが移動したとき、移動元から移動先へ短い残像を描く
const float DURATION = 0.2; // 残像が消えるまでの秒数

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    fragColor = texture(iChannel0, fragCoord / iResolution.xy);

    float t = clamp((iTime - iTimeCursorChange) / DURATION, 0.0, 1.0);
    if (t >= 1.0) return;

    // xy はカーソルの左上寄りの角（-X, +Y）、zw は幅と高さ
    vec2 toCenter = vec2(0.5, -0.5);
    vec2 head = iCurrentCursor.xy + iCurrentCursor.zw * toCenter;
    vec2 prev = iPreviousCursor.xy + iPreviousCursor.zw * toCenter;
    // 尾は時間とともに現在位置へ縮む
    vec2 tail = mix(prev, head, 1.0 - pow(1.0 - t, 3.0));

    vec2 seg = head - tail;
    float len2 = dot(seg, seg);
    if (len2 < 1.0) return;

    float h = clamp(dot(fragCoord - tail, seg) / len2, 0.0, 1.0);
    float dist = length(fragCoord - tail - seg * h);
    float radius = iCurrentCursor.z * 0.5 * h; // 尾に向かって細くする
    float mask = 1.0 - smoothstep(radius - 1.0, radius + 1.0, dist);

    // 現在のカーソルの上には重ねない
    vec2 d = abs(fragCoord - head) - iCurrentCursor.zw * 0.5;
    mask *= step(0.0, max(d.x, d.y));

    float a = mask * h * (1.0 - t) * 0.8;
    fragColor.rgb = mix(fragColor.rgb, iCurrentCursorColor.rgb, a);
    fragColor.a = max(fragColor.a, a);
}
