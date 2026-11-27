/* 図の共通ライブラリ。各図の *.js は Fig.define({...}) を呼ぶだけで、描画は render.sh が headless Chrome で行う。
 * rough.js は render.sh が先に読み込む (グローバル `rough`)。 */
(function () {
  var NS = "http://www.w3.org/2000/svg";

  // PNG は mkdocs の light / dark どちらでも読めるよう、白背景 + 固定パレットにする
  var C = {
    bg: "#ffffff", fg: "#23262b", muted: "#5f646d",
    plat: "#2f6fb0", svc: "#b4532a", pod: "#8a5fb0", ok: "#3d8a5a", warn: "#c0392b"
  };
  var FONT = '"Klee One", "Noto Sans CJK JP", "Hiragino Maru Gothic ProN", "Yu Gothic", sans-serif';

  function el(parent, tag, attrs, text) {
    var e = document.createElementNS(NS, tag);
    for (var k in attrs) e.setAttribute(k, attrs[k]);
    if (text != null) e.textContent = text;
    parent.appendChild(e);
    return e;
  }

  function context(svg) {
    var rc = rough.svg(svg);
    var seed = 3;
    function nextSeed() { return seed++; }

    var defs = el(svg, "defs", {});
    var m = el(defs, "marker", { id: "ah", viewBox: "0 0 10 10", refX: 8, refY: 5, markerWidth: 7, markerHeight: 7, orient: "auto-start-reverse" });
    el(m, "path", { d: "M1 1 L9 5 L1 9", fill: "none", stroke: "context-stroke", "stroke-width": 1.6, "stroke-linecap": "round" });

    var d = {
      C: C,
      text: function (x, y, s, o) {
        o = o || {};
        el(svg, "text", { x: x, y: y, "text-anchor": o.anchor || "middle", "font-size": o.size || 14,
          "font-weight": o.bold ? 600 : 400, fill: o.color || C.fg, "font-family": FONT }, s);
      },
      lines: function (x, y, arr, o) {
        o = o || {};
        arr.forEach(function (s, i) { d.text(x, y + i * (o.lh || 18), s, o); });
      },
      // 色付きの箱。斜線は薄く、枠線は濃くする
      box: function (x, y, w, h, title, sub, color, o) {
        o = o || {};
        var col = C[color] || C.fg;
        var g = rc.rectangle(x, y, w, h, { stroke: col, strokeWidth: 1.8, roughness: 1.3, seed: nextSeed(),
          fill: col, fillStyle: "hachure", fillWeight: 0.6, hachureGap: 12, hachureAngle: -40 });
        var ps = g.querySelectorAll("path");
        for (var i = 0; i < ps.length; i++) {
          if (ps[i].getAttribute("stroke-width") !== "1.8") ps[i].setAttribute("opacity", 0.22);
        }
        svg.appendChild(g);
        if (title) d.text(x + w / 2, y + (sub ? h / 2 - 3 : h / 2 + 5), title, { bold: true, size: o.size || 15 });
        if (sub) d.text(x + w / 2, y + h / 2 + 16, sub, { size: 11.5, color: C.muted });
      },
      group: function (x, y, w, h, label, color, dashed) {
        var col = C[color] || C.muted;
        svg.appendChild(rc.rectangle(x, y, w, h, { stroke: col, strokeWidth: 1.3, roughness: 1.6, seed: nextSeed(), strokeLineDash: dashed ? [7, 6] : undefined }));
        if (label) d.text(x + 10, y + 18, label, { anchor: "start", size: 12.5, color: col, bold: true });
      },
      arrow: function (x1, y1, x2, y2, label, o) {
        o = o || {};
        var col = o.color ? C[o.color] : C.fg;
        var g = rc.line(x1, y1, x2, y2, { stroke: col, strokeWidth: 1.7, roughness: 1.2, seed: nextSeed(), strokeLineDash: o.dashed ? [6, 6] : undefined });
        g.setAttribute("marker-end", "url(#ah)");
        g.setAttribute("color", col);
        svg.appendChild(g);
        if (label) {
          d.text((x1 + x2) / 2 + (o.dx || 0), (y1 + y2) / 2 + (o.dy == null ? -7 : o.dy), label, { size: 11.5, color: o.color ? col : C.muted, anchor: o.anchor });
        }
      },
      poly: function (pts, o) {
        o = o || {};
        var col = o.color ? C[o.color] : C.fg;
        var g = rc.linearPath(pts, { stroke: col, strokeWidth: 1.7, roughness: 1.2, seed: nextSeed(), strokeLineDash: o.dashed ? [6, 6] : undefined });
        g.setAttribute("marker-end", "url(#ah)");
        g.setAttribute("color", col);
        svg.appendChild(g);
      },
      line: function (x1, y1, x2, y2, color, w) {
        svg.appendChild(rc.line(x1, y1, x2, y2, { stroke: C[color] || C.fg, strokeWidth: w || 1.6, roughness: 1.4, seed: nextSeed() }));
      },
      // 依存図の凡例 (作る / 名前で参照 / label で選ぶ)
      legend: function () {
        d.arrow(10, 18, 60, 18, "", { color: "ok" });
        d.text(68, 22, "作る (所有)", { anchor: "start", size: 12, color: C.ok });
        d.arrow(170, 18, 220, 18, "", {});
        d.text(228, 22, "名前で参照", { anchor: "start", size: 12 });
        d.arrow(330, 18, 380, 18, "", { dashed: true });
        d.text(388, 22, "label で選ぶ", { anchor: "start", size: 12, color: C.muted });
      }
    };
    return d;
  }

  window.Fig = {
    // spec: { w, h, draw(d) }。w / h は viewBox の幅と高さ (PNG は 2 倍で出力される)
    define: function (spec) {
      function run() {
        var svg = el(document.body, "svg", { xmlns: NS, width: spec.w, height: spec.h, viewBox: "0 0 " + spec.w + " " + spec.h });
        el(svg, "rect", { x: 0, y: 0, width: spec.w, height: spec.h, fill: C.bg });
        spec.draw(context(svg));
        document.documentElement.setAttribute("data-ready", "1");
      }
      // Klee One の読み込み後に描く (未読込だと文字幅が変わる)
      if (document.fonts && document.fonts.ready) document.fonts.ready.then(run); else run();
    }
  };
})();
