$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: corner pad 80 x 70, fillet R12
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 3;               // bolt hole radius
plate_t = 8;              // plate thickness, Z (extrusion height)
leg_a = 80;               // base leg
leg_b = 70;               // height leg
fillet_r = 12;            // right-angle fillet radius

hole_d1 = 2 * hole_r + 2;
hole_d2 = 2 * hole_r;

profile = [[12, 0], [80, 0], [0, 70], [0, 12], [0.409, 8.894], [1.608, 6], [3.515, 3.515], [6, 1.608], [8.894, 0.409]];  // primary outline, 9 points, counter clockwise
void_1 = [[27.927, 16.163], [27.207, 17.791], [25.851, 18.946], [24.13, 19.398], [22.382, 19.058], [20.955, 17.994], [20.131, 16.416], [20.073, 14.637], [20.793, 13.009], [22.149, 11.854], [23.87, 11.402], [25.618, 11.742], [27.045, 12.806], [27.869, 14.384]];  // mount hole 1, 14 points
void_2 = [[17.345, 32.072], [16.805, 33.293], [15.789, 34.159], [14.497, 34.498], [13.187, 34.244], [12.116, 33.445], [11.498, 32.262], [11.455, 30.928], [11.995, 29.707], [13.011, 28.841], [14.303, 28.502], [15.613, 28.756], [16.684, 29.555], [17.302, 30.738]];  // mount hole 2, 14 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
}
