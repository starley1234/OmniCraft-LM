$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: corner pad 80 x 60, fillet R12
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 3.5;             // bolt hole radius
plate_t = 6;              // plate thickness, Z (extrusion height)
leg_a = 80;               // base leg
leg_b = 60;               // height leg
fillet_r = 12;            // right-angle fillet radius

hole_d1 = 2 * hole_r + 2;
hole_d2 = 2 * hole_r;

profile = [[12, 0], [80, 0], [0, 60], [0, 12], [0.409, 8.894], [1.608, 6], [3.515, 3.515], [6, 1.608], [8.894, 0.409]];  // primary outline, 9 points, counter clockwise
void_1 = [[28.417, 14.059], [27.607, 15.89], [26.083, 17.189], [24.146, 17.698], [22.18, 17.316], [20.575, 16.118], [19.648, 14.343], [19.583, 12.341], [20.393, 10.51], [21.917, 9.211], [23.854, 8.702], [25.82, 9.084], [27.425, 10.282], [28.352, 12.057]];  // mount hole 1, 14 points
void_2 = [[17.836, 27.668], [17.206, 29.092], [16.02, 30.103], [14.513, 30.498], [12.984, 30.201], [11.736, 29.27], [11.015, 27.889], [10.964, 26.332], [11.594, 24.908], [12.78, 23.897], [14.287, 23.502], [15.816, 23.799], [17.064, 24.73], [17.785, 26.111]];  // mount hole 2, 14 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
}
