$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: gusset 50 x 40
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 3.5;             // bolt hole radius
plate_t = 5;              // plate thickness, Z (extrusion height)
gus_a = 50;               // base length
gus_b = 40;               // height
top_x = 25;               // top edge X of the angled cut
light_r = 7.2;            // lightening hole radius

light_d = 2 * light_r;

profile = [[4, 0], [25, 0], [50, 0], [25, 40], [0, 40], [0, 4]];  // primary outline, 6 points, counter clockwise
void_1 = [[23.068, 16.574], [22.004, 19.174], [20.026, 21.169], [17.435, 22.255], [14.626, 22.268], [12.026, 21.204], [10.031, 19.226], [8.945, 16.635], [8.932, 13.826], [9.996, 11.226], [11.974, 9.231], [14.565, 8.145], [17.374, 8.132], [19.974, 9.196], [21.969, 11.174], [23.055, 13.765]];  // lightening hole, 16 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
