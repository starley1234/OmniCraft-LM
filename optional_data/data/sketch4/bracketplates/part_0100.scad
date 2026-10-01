$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: corner pad 80 x 50, fillet R15
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 3;               // bolt hole radius
plate_t = 8;              // plate thickness, Z (extrusion height)
leg_a = 80;               // base leg
leg_b = 50;               // height leg
fillet_r = 15;            // right-angle fillet radius

hole_d1 = 2 * hole_r + 2;
hole_d2 = 2 * hole_r;

profile = [[15, 0], [80, 0], [0, 50], [0, 15], [0.511, 11.118], [2.01, 7.5], [4.393, 4.393], [7.5, 2.01], [11.118, 0.511]];  // primary outline, 9 points, counter clockwise
void_1 = [[27.927, 11.763], [27.207, 13.391], [25.851, 14.546], [24.13, 14.998], [22.382, 14.658], [20.955, 13.594], [20.131, 12.016], [20.073, 10.237], [20.793, 8.609], [22.149, 7.454], [23.87, 7.002], [25.618, 7.342], [27.045, 8.406], [27.869, 9.984]];  // mount hole 1, 14 points
void_2 = [[17.345, 23.072], [16.805, 24.293], [15.789, 25.159], [14.497, 25.498], [13.187, 25.244], [12.116, 24.445], [11.498, 23.262], [11.455, 21.928], [11.995, 20.707], [13.011, 19.841], [14.303, 19.502], [15.613, 19.756], [16.684, 20.555], [17.302, 21.738]];  // mount hole 2, 14 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
}
