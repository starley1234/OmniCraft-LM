$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: gusset 60 x 40
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 3;               // bolt hole radius
plate_t = 8;              // plate thickness, Z (extrusion height)
gus_a = 60;               // base length
gus_b = 40;               // height
top_x = 30;               // top edge X of the angled cut
light_r = 7.2;            // lightening hole radius
fit_tol = 0.02;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

light_d = 2 * light_r;

profile = [[4, 0], [30, 0], [60, 0], [30, 40], [0, 40], [0, 4]];  // primary outline, 6 points, counter clockwise
void_1 = [[26.268, 16.574], [25.204, 19.174], [23.226, 21.169], [20.635, 22.255], [17.826, 22.268], [15.226, 21.204], [13.231, 19.226], [12.145, 16.635], [12.132, 13.826], [13.196, 11.226], [15.174, 9.231], [17.765, 8.145], [20.574, 8.132], [23.174, 9.196], [25.169, 11.174], [26.255, 13.765]];  // lightening hole, 16 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
