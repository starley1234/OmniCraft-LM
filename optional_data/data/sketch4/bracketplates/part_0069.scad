$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: corner pad 70 x 70, fillet R10
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 4;               // bolt hole radius
plate_t = 5;              // plate thickness, Z (extrusion height)
leg_a = 70;               // base leg
leg_b = 70;               // height leg
fillet_r = 10;            // right-angle fillet radius

hole_d1 = 2 * hole_r + 2;
hole_d2 = 2 * hole_r;

profile = [[10, 0], [70, 0], [0, 70], [0, 10], [0.341, 7.412], [1.34, 5], [2.929, 2.929], [5, 1.34], [7.412, 0.341]];  // primary outline, 9 points, counter clockwise
void_1 = [[25.908, 16.354], [25.008, 18.389], [23.314, 19.832], [21.162, 20.397], [18.978, 19.973], [17.194, 18.642], [16.164, 16.67], [16.092, 14.446], [16.992, 12.411], [18.686, 10.968], [20.838, 10.403], [23.022, 10.827], [24.806, 12.158], [25.836, 14.13]];  // mount hole 1, 14 points
void_2 = [[16.527, 32.263], [15.807, 33.891], [14.451, 35.046], [12.73, 35.498], [10.982, 35.158], [9.555, 34.094], [8.731, 32.516], [8.673, 30.737], [9.393, 29.109], [10.749, 27.954], [12.47, 27.502], [14.218, 27.842], [15.645, 28.906], [16.469, 30.484]];  // mount hole 2, 14 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
}
