$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: corner pad 70 x 70, fillet R12
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 3;               // bolt hole radius
plate_t = 8;              // plate thickness, Z (extrusion height)
leg_a = 70;               // base leg
leg_b = 70;               // height leg
fillet_r = 12;            // right-angle fillet radius

hole_d1 = 2 * hole_r + 2;
hole_d2 = 2 * hole_r;

profile = [[12, 0], [70, 0], [0, 70], [0, 12], [0.409, 8.894], [1.608, 6], [3.515, 3.515], [6, 1.608], [8.894, 0.409]];  // primary outline, 9 points, counter clockwise
void_1 = [[24.927, 16.163], [24.207, 17.791], [22.851, 18.946], [21.13, 19.398], [19.382, 19.058], [17.955, 17.994], [17.131, 16.416], [17.073, 14.637], [17.793, 13.009], [19.149, 11.854], [20.87, 11.402], [22.618, 11.742], [24.045, 12.806], [24.869, 14.384]];  // mount hole 1, 14 points
void_2 = [[15.545, 32.072], [15.005, 33.293], [13.989, 34.159], [12.697, 34.498], [11.387, 34.244], [10.316, 33.445], [9.698, 32.262], [9.655, 30.928], [10.195, 29.707], [11.211, 28.841], [12.503, 28.502], [13.813, 28.756], [14.884, 29.555], [15.502, 30.738]];  // mount hole 2, 14 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
}
