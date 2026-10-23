export const drawAttackSymbol = (context, cx: number, cy: number, radius = 10, dieColor = "#111") => {
  context.save();
  context.beginPath();

  if (dieColor === "#c62828" || dieColor === "#1565c0") {
    // Red attack dice are D8s; blue attack dice are D12s. Give the die distinct triangular facets
    // and a small face value so it reads as a die, not just a red diamond.
    context.moveTo(cx, cy - radius);
    context.lineTo(cx + radius, cy);
    context.lineTo(cx, cy + radius);
    context.lineTo(cx - radius, cy);
    context.closePath();
    context.fillStyle = dieColor;
    context.fill();
    context.strokeStyle = dieColor === "#1565c0" ? "#0d2f66" : "#7f1515";
    context.lineWidth = 1;
    context.stroke();

    // Faceted triangular faces and contrasting highlights make the colored die readable at card size.
    context.beginPath();
    context.moveTo(cx, cy - radius);
    context.lineTo(cx - radius, cy);
    context.lineTo(cx, cy);
    context.closePath();
    context.fillStyle = dieColor === "#1565c0" ? "#64b5f6" : "#ef7777";
    context.fill();

    context.beginPath();
    context.moveTo(cx, cy - radius);
    context.lineTo(cx + radius, cy);
    context.lineTo(cx, cy);
    context.closePath();
    context.fillStyle = dieColor === "#1565c0" ? "#1565c0" : "#b51f1f";
    context.fill();

    context.beginPath();
    context.moveTo(cx - radius, cy);
    context.lineTo(cx, cy + radius);
    context.lineTo(cx, cy);
    context.closePath();
    context.fillStyle = dieColor === "#1565c0" ? "#1e88e5" : "#d93636";
    context.fill();

    context.beginPath();
    context.moveTo(cx + radius, cy);
    context.lineTo(cx, cy + radius);
    context.lineTo(cx, cy);
    context.closePath();
    context.fillStyle = dieColor === "#1565c0" ? "#0d47a1" : "#981b1b";
    context.fill();

    context.beginPath();
    context.moveTo(cx, cy - radius);
    context.lineTo(cx, cy);
    context.lineTo(cx - radius, cy);
    context.moveTo(cx, cy - radius);
    context.lineTo(cx, cy);
    context.lineTo(cx + radius, cy);
    context.moveTo(cx - radius, cy);
    context.lineTo(cx, cy + radius);
    context.lineTo(cx + radius, cy);
    context.strokeStyle = dieColor === "#1565c0" ? "#bbdefb" : "#ffd0d0";
    context.lineWidth = 0.7;
    context.stroke();

    context.fillStyle = "#fff";
    context.font = `bold ${Math.max(8, radius * 0.9)}px Arial`;
    context.textAlign = "center";
    context.textBaseline = "middle";
    context.fillText(dieColor === "#1565c0" ? "12" : "8", cx, cy + 0.5);
  } else {
    // Black attack dice are D20s, shown as a compact faceted polygon.
    context.moveTo(cx, cy - radius);
    context.lineTo(cx + radius * 0.78, cy - radius * 0.48);
    context.lineTo(cx + radius, cy + radius * 0.28);
    context.lineTo(cx + radius * 0.48, cy + radius * 0.88);
    context.lineTo(cx - radius * 0.48, cy + radius * 0.88);
    context.lineTo(cx - radius, cy + radius * 0.28);
    context.lineTo(cx - radius * 0.78, cy - radius * 0.48);
    context.closePath();
    context.fillStyle = dieColor;
    context.fill();
    context.strokeStyle = "#777";
    context.lineWidth = 1;
    context.stroke();

    context.beginPath();
    context.moveTo(cx, cy - radius);
    context.lineTo(cx - radius * 0.18, cy - radius * 0.12);
    context.lineTo(cx - radius * 0.78, cy - radius * 0.48);
    context.moveTo(cx, cy - radius);
    context.lineTo(cx + radius * 0.18, cy - radius * 0.12);
    context.lineTo(cx + radius * 0.78, cy - radius * 0.48);
    context.moveTo(cx - radius * 0.18, cy - radius * 0.12);
    context.lineTo(cx - radius * 0.62, cy + radius * 0.34);
    context.lineTo(cx - radius * 0.48, cy + radius * 0.88);
    context.moveTo(cx + radius * 0.18, cy - radius * 0.12);
    context.lineTo(cx + radius * 0.62, cy + radius * 0.34);
    context.lineTo(cx + radius * 0.48, cy + radius * 0.88);
    context.moveTo(cx - radius * 0.62, cy + radius * 0.34);
    context.lineTo(cx, cy + radius * 0.55);
    context.lineTo(cx + radius * 0.62, cy + radius * 0.34);
    context.strokeStyle = "#ddd";
    context.lineWidth = 0.7;
    context.stroke();
  }
  context.restore();
};

export const drawArmourSymbol = (context, cx: number, cy: number, size = 10) => {
  context.beginPath();
  context.moveTo(cx, cy - size);
  context.lineTo(cx + size * 0.82, cy - size * 0.55);
  context.lineTo(cx + size * 0.68, cy + size * 0.35);
  context.quadraticCurveTo(cx, cy + size * 1.2, cx, cy + size * 1.2);
  context.quadraticCurveTo(cx, cy + size * 1.2, cx - size * 0.68, cy + size * 0.35);
  context.lineTo(cx - size * 0.82, cy - size * 0.55);
  context.closePath();
  context.fillStyle = "#171717";
  context.fill();
  context.strokeStyle = "#777";
  context.lineWidth = 1.5;
  context.stroke();
};

export const drawLightning = (context, x: number, y: number) => {
  context.beginPath();
  context.moveTo(x + 13, y);
  context.lineTo(x, y + 17);
  context.lineTo(x + 10, y + 17);
  context.lineTo(x + 5, y + 32);
  context.lineTo(x + 24, y + 12);
  context.lineTo(x + 14, y + 12);
  context.closePath();
  context.fillStyle = "#f0c84b";
  context.fill();
};