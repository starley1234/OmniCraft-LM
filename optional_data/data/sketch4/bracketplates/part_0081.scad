$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: corner pad 60 x 70, fillet R10
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 3;               // bolt hole radius
plate_t = 8;              // plate thickness, Z (extrusion height)
leg_a = 60;               // base leg
leg_b = 70;               // height leg
fillet_r = 10;            // right-angle fillet radius

hole_d1 = 2 * hole_r + 2;
hole_d2 = 2 * hole_r;

profile = [[10, 0], [60, 0], [0, 70], [0, 10], [0.341, 7.412], [1.34, 5], [2.929, 2.929], [5, 1.34], [7.412, 0.341]];  // primary outline, 9 points, counter clockwise
void_1 = [[21.927, 16.163], [21.207, 17.791], [19.851, 18.946], [18.13, 19.398], [16.382, 19.058], [14.955, 17.994], [14.131, 16.416], [14.073, 14.637], [14.793, 13.009], [16.149, 11.854], [17.87, 11.402], [19.618, 11.742], [21.045, 12.806], [21.869, 14.384]];  // mount hole 1, 14 points
void_2 = [[13.745, 32.072], [13.205, 33.293], [12.189, 34.159], [10.897, 34.498], [9.587, 34.244], [8.516, 33.445], [7.898, 32.262], [7.855, 30.928], [8.395, 29.707], [9.411, 28.841], [10.703, 28.502], [12.013, 28.756], [13.084, 29.555], [13.702, 30.738]];  // mount hole 2, 14 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
}
