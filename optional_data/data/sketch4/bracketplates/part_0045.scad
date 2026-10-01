$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: corner pad 60 x 50, fillet R15
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 4;               // bolt hole radius
plate_t = 5;              // plate thickness, Z (extrusion height)
leg_a = 60;               // base leg
leg_b = 50;               // height leg
fillet_r = 15;            // right-angle fillet radius

hole_d1 = 2 * hole_r + 2;
hole_d2 = 2 * hole_r;

profile = [[15, 0], [60, 0], [0, 50], [0, 15], [0.511, 11.118], [2.01, 7.5], [4.393, 4.393], [7.5, 2.01], [11.118, 0.511]];  // primary outline, 9 points, counter clockwise
void_1 = [[22.908, 11.954], [22.008, 13.989], [20.314, 15.432], [18.162, 15.997], [15.978, 15.573], [14.194, 14.242], [13.164, 12.27], [13.092, 10.046], [13.992, 8.011], [15.686, 6.568], [17.838, 6.003], [20.022, 6.427], [21.806, 7.758], [22.836, 9.73]];  // mount hole 1, 14 points
void_2 = [[14.727, 23.263], [14.007, 24.891], [12.651, 26.046], [10.93, 26.498], [9.182, 26.158], [7.755, 25.094], [6.931, 23.516], [6.873, 21.737], [7.593, 20.109], [8.949, 18.954], [10.67, 18.502], [12.418, 18.842], [13.845, 19.906], [14.669, 21.484]];  // mount hole 2, 14 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
}
