$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: corner pad 60 x 60, fillet R10
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 3;               // bolt hole radius
plate_t = 8;              // plate thickness, Z (extrusion height)
leg_a = 60;               // base leg
leg_b = 60;               // height leg
fillet_r = 10;            // right-angle fillet radius

hole_d1 = 2 * hole_r + 2;
hole_d2 = 2 * hole_r;

profile = [[10, 0], [60, 0], [0, 60], [0, 10], [0.341, 7.412], [1.34, 5], [2.929, 2.929], [5, 1.34], [7.412, 0.341]];  // primary outline, 9 points, counter clockwise
void_1 = [[21.927, 13.963], [21.207, 15.591], [19.851, 16.746], [18.13, 17.198], [16.382, 16.858], [14.955, 15.794], [14.131, 14.216], [14.073, 12.437], [14.793, 10.809], [16.149, 9.654], [17.87, 9.202], [19.618, 9.542], [21.045, 10.606], [21.869, 12.184]];  // mount hole 1, 14 points
void_2 = [[13.745, 27.572], [13.205, 28.793], [12.189, 29.659], [10.897, 29.998], [9.587, 29.744], [8.516, 28.945], [7.898, 27.762], [7.855, 26.428], [8.395, 25.207], [9.411, 24.341], [10.703, 24.002], [12.013, 24.256], [13.084, 25.055], [13.702, 26.238]];  // mount hole 2, 14 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
}
