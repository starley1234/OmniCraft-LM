$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: corner pad 80 x 70, fillet R12
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 4;               // bolt hole radius
plate_t = 5;              // plate thickness, Z (extrusion height)
leg_a = 80;               // base leg
leg_b = 70;               // height leg
fillet_r = 12;            // right-angle fillet radius

hole_d1 = 2 * hole_r + 2;
hole_d2 = 2 * hole_r;

profile = [[12, 0], [80, 0], [0, 70], [0, 12], [0.409, 8.894], [1.608, 6], [3.515, 3.515], [6, 1.608], [8.894, 0.409]];  // primary outline, 9 points, counter clockwise
void_1 = [[28.908, 16.354], [28.008, 18.389], [26.314, 19.832], [24.162, 20.397], [21.978, 19.973], [20.194, 18.642], [19.164, 16.67], [19.092, 14.446], [19.992, 12.411], [21.686, 10.968], [23.838, 10.403], [26.022, 10.827], [27.806, 12.158], [28.836, 14.13]];  // mount hole 1, 14 points
void_2 = [[18.327, 32.263], [17.607, 33.891], [16.251, 35.046], [14.53, 35.498], [12.782, 35.158], [11.355, 34.094], [10.531, 32.516], [10.473, 30.737], [11.193, 29.109], [12.549, 27.954], [14.27, 27.502], [16.018, 27.842], [17.445, 28.906], [18.269, 30.484]];  // mount hole 2, 14 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
}
