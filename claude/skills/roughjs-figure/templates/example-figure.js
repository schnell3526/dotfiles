// size: 900x270
// hosts に無印 / blue / green を並べ、クラスタ切り替えを DNS の向き先変更で行う
Fig.define({
  w: 900,
  h: 270,
  draw: function (d) {
    var C = d.C;
    d.box(10, 20, 330, 230, "", "", "plat");
    d.text(26, 46, "ホスト名 (Gateway / VirtualService の hosts)", { anchor: "start", size: 12.5, color: C.plat, bold: true });
    d.text(26, 94, "app.blue.example.com", { anchor: "start", size: 14, bold: true });
    d.text(26, 154, "app.example.com", { anchor: "start", size: 14, bold: true });
    d.text(26, 214, "app.green.example.com", { anchor: "start", size: 14, bold: true });

    d.box(600, 20, 290, 90, "cluster blue", "例: 現行クラスタ", "svc");
    d.box(600, 160, 290, 90, "cluster green", "例: 新クラスタ", "svc");

    d.arrow(340, 90, 600, 70, "常に blue を指す", { dy: -8 });
    d.arrow(340, 210, 600, 200, "常に green を指す", { dy: 18 });
    d.arrow(340, 144, 600, 104, "切り替え前", { dx: 30, dy: -14 });
    d.arrow(340, 156, 600, 176, "切り替え後", { dashed: true, color: "warn", dx: 30, dy: 16 });
    d.text(745, 268, "同じマニフェストを両方のクラスタに適用する", { size: 11.5, color: C.muted });
  }
});
