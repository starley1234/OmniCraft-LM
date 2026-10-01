$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: gusset 70 x 40
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 3.5;             // bolt hole radius
plate_t = 5;              // plate thickness, Z (extrusion height)
gus_a = 70;               // base length
gus_b = 40;               // height
top_x = 31.5;             // top edge X of the angled cut
light_r = 7.2;            // lightening hole radius

light_d = 2 * light_r;

profile = [[4, 0], [35, 0], [70, 0], [31.5, 40], [0, 40], [0, 4]];  // primary outline, 6 points, counter clockwise
void_1 = [[29.468, 16.574], [28.404, 19.174], [26.426, 21.169], [23.835, 22.255], [21.026, 22.268], [18.426, 21.204], [16.431, 19.226], [15.345, 16.635], [15.332, 13.826], [16.396, 11.226], [18.374, 9.231], [20.965, 8.145], [23.774, 8.132], [26.374, 9.196], [28.369, 11.174], [29.455, 13.765]];  // lightening hole, 16 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
