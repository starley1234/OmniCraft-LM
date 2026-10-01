$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: gusset 70 x 60
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 3;               // bolt hole radius
plate_t = 6;              // plate thickness, Z (extrusion height)
gus_a = 70;               // base length
gus_b = 60;               // height
top_x = 28;               // top edge X of the angled cut
light_r = 10.8;           // lightening hole radius

light_d = 2 * light_r;

profile = [[4, 0], [35, 0], [70, 0], [28, 60], [0, 60], [0, 4]];  // primary outline, 6 points, counter clockwise
void_1 = [[33.002, 24.861], [31.406, 28.761], [28.439, 31.754], [24.553, 33.383], [20.339, 33.402], [16.439, 31.806], [13.446, 28.839], [11.817, 24.953], [11.798, 20.739], [13.394, 16.839], [16.361, 13.846], [20.247, 12.217], [24.461, 12.198], [28.361, 13.794], [31.354, 16.761], [32.983, 20.647]];  // lightening hole, 16 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
