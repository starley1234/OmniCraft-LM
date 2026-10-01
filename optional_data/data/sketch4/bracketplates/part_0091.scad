$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: corner pad 70 x 50, fillet R12
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 3;               // bolt hole radius
plate_t = 5;              // plate thickness, Z (extrusion height)
leg_a = 70;               // base leg
leg_b = 50;               // height leg
fillet_r = 12;            // right-angle fillet radius

hole_d1 = 2 * hole_r + 2;
hole_d2 = 2 * hole_r;

profile = [[12, 0], [70, 0], [0, 50], [0, 12], [0.409, 8.894], [1.608, 6], [3.515, 3.515], [6, 1.608], [8.894, 0.409]];  // primary outline, 9 points, counter clockwise
void_1 = [[24.927, 11.763], [24.207, 13.391], [22.851, 14.546], [21.13, 14.998], [19.382, 14.658], [17.955, 13.594], [17.131, 12.016], [17.073, 10.237], [17.793, 8.609], [19.149, 7.454], [20.87, 7.002], [22.618, 7.342], [24.045, 8.406], [24.869, 9.984]];  // mount hole 1, 14 points
void_2 = [[15.545, 23.072], [15.005, 24.293], [13.989, 25.159], [12.697, 25.498], [11.387, 25.244], [10.316, 24.445], [9.698, 23.262], [9.655, 21.928], [10.195, 20.707], [11.211, 19.841], [12.503, 19.502], [13.813, 19.756], [14.884, 20.555], [15.502, 21.738]];  // mount hole 2, 14 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
}
