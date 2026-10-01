$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: gusset 60 x 50
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 3.5;             // bolt hole radius
plate_t = 6;              // plate thickness, Z (extrusion height)
gus_a = 60;               // base length
gus_b = 50;               // height
top_x = 30;               // top edge X of the angled cut
light_r = 9;              // lightening hole radius

light_d = 2 * light_r;

profile = [[4, 0], [30, 0], [60, 0], [30, 50], [0, 50], [0, 4]];  // primary outline, 6 points, counter clockwise
void_1 = [[28.035, 20.717], [26.705, 23.967], [24.233, 26.461], [20.994, 27.819], [17.483, 27.835], [14.233, 26.505], [11.739, 24.033], [10.381, 20.794], [10.365, 17.283], [11.695, 14.033], [14.167, 11.539], [17.406, 10.181], [20.917, 10.165], [24.167, 11.495], [26.661, 13.967], [28.019, 17.206]];  // lightening hole, 16 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
