$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: corner pad 60 x 50, fillet R12
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 3;               // bolt hole radius
plate_t = 8;              // plate thickness, Z (extrusion height)
leg_a = 60;               // base leg
leg_b = 50;               // height leg
fillet_r = 12;            // right-angle fillet radius

hole_d1 = 2 * hole_r + 2;
hole_d2 = 2 * hole_r;

profile = [[12, 0], [60, 0], [0, 50], [0, 12], [0.409, 8.894], [1.608, 6], [3.515, 3.515], [6, 1.608], [8.894, 0.409]];  // primary outline, 9 points, counter clockwise
void_1 = [[21.927, 11.763], [21.207, 13.391], [19.851, 14.546], [18.13, 14.998], [16.382, 14.658], [14.955, 13.594], [14.131, 12.016], [14.073, 10.237], [14.793, 8.609], [16.149, 7.454], [17.87, 7.002], [19.618, 7.342], [21.045, 8.406], [21.869, 9.984]];  // mount hole 1, 14 points
void_2 = [[13.745, 23.072], [13.205, 24.293], [12.189, 25.159], [10.897, 25.498], [9.587, 25.244], [8.516, 24.445], [7.898, 23.262], [7.855, 21.928], [8.395, 20.707], [9.411, 19.841], [10.703, 19.502], [12.013, 19.756], [13.084, 20.555], [13.702, 21.738]];  // mount hole 2, 14 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
}
