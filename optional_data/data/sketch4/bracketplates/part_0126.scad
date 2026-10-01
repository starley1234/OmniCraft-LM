$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: gusset 60 x 60
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 3;               // bolt hole radius
plate_t = 6;              // plate thickness, Z (extrusion height)
gus_a = 60;               // base length
gus_b = 60;               // height
top_x = 24;               // top edge X of the angled cut
light_r = 10.8;           // lightening hole radius

light_d = 2 * light_r;

profile = [[4, 0], [30, 0], [60, 0], [24, 60], [0, 60], [0, 4]];  // primary outline, 6 points, counter clockwise
void_1 = [[29.802, 24.861], [28.206, 28.761], [25.239, 31.754], [21.353, 33.383], [17.139, 33.402], [13.239, 31.806], [10.246, 28.839], [8.617, 24.953], [8.598, 20.739], [10.194, 16.839], [13.161, 13.846], [17.047, 12.217], [21.261, 12.198], [25.161, 13.794], [28.154, 16.761], [29.783, 20.647]];  // lightening hole, 16 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
