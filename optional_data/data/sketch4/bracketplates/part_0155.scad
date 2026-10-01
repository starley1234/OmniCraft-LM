$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: corner pad 70 x 50, fillet R10
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 4;               // bolt hole radius
plate_t = 5;              // plate thickness, Z (extrusion height)
leg_a = 70;               // base leg
leg_b = 50;               // height leg
fillet_r = 10;            // right-angle fillet radius

hole_d1 = 2 * hole_r + 2;
hole_d2 = 2 * hole_r;

profile = [[10, 0], [70, 0], [0, 50], [0, 10], [0.341, 7.412], [1.34, 5], [2.929, 2.929], [5, 1.34], [7.412, 0.341]];  // primary outline, 9 points, counter clockwise
void_1 = [[25.908, 11.954], [25.008, 13.989], [23.314, 15.432], [21.162, 15.997], [18.978, 15.573], [17.194, 14.242], [16.164, 12.27], [16.092, 10.046], [16.992, 8.011], [18.686, 6.568], [20.838, 6.003], [23.022, 6.427], [24.806, 7.758], [25.836, 9.73]];  // mount hole 1, 14 points
void_2 = [[16.527, 23.263], [15.807, 24.891], [14.451, 26.046], [12.73, 26.498], [10.982, 26.158], [9.555, 25.094], [8.731, 23.516], [8.673, 21.737], [9.393, 20.109], [10.749, 18.954], [12.47, 18.502], [14.218, 18.842], [15.645, 19.906], [16.469, 21.484]];  // mount hole 2, 14 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
}
