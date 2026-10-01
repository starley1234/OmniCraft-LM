$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: corner pad 80 x 50, fillet R15
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 4;               // bolt hole radius
plate_t = 8;              // plate thickness, Z (extrusion height)
leg_a = 80;               // base leg
leg_b = 50;               // height leg
fillet_r = 15;            // right-angle fillet radius

hole_d1 = 2 * hole_r + 2;
hole_d2 = 2 * hole_r;

profile = [[15, 0], [80, 0], [0, 50], [0, 15], [0.511, 11.118], [2.01, 7.5], [4.393, 4.393], [7.5, 2.01], [11.118, 0.511]];  // primary outline, 9 points, counter clockwise
void_1 = [[28.908, 11.954], [28.008, 13.989], [26.314, 15.432], [24.162, 15.997], [21.978, 15.573], [20.194, 14.242], [19.164, 12.27], [19.092, 10.046], [19.992, 8.011], [21.686, 6.568], [23.838, 6.003], [26.022, 6.427], [27.806, 7.758], [28.836, 9.73]];  // mount hole 1, 14 points
void_2 = [[18.327, 23.263], [17.607, 24.891], [16.251, 26.046], [14.53, 26.498], [12.782, 26.158], [11.355, 25.094], [10.531, 23.516], [10.473, 21.737], [11.193, 20.109], [12.549, 18.954], [14.27, 18.502], [16.018, 18.842], [17.445, 19.906], [18.269, 21.484]];  // mount hole 2, 14 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
}
