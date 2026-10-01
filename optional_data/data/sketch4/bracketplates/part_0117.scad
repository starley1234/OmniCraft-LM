$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: gusset 50 x 50
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 3.5;             // bolt hole radius
plate_t = 6;              // plate thickness, Z (extrusion height)
gus_a = 50;               // base length
gus_b = 50;               // height
top_x = 25;               // top edge X of the angled cut
light_r = 9;              // lightening hole radius

light_d = 2 * light_r;

profile = [[4, 0], [25, 0], [50, 0], [25, 50], [0, 50], [0, 4]];  // primary outline, 6 points, counter clockwise
void_1 = [[24.835, 20.717], [23.505, 23.967], [21.033, 26.461], [17.794, 27.819], [14.283, 27.835], [11.033, 26.505], [8.539, 24.033], [7.181, 20.794], [7.165, 17.283], [8.495, 14.033], [10.967, 11.539], [14.206, 10.181], [17.717, 10.165], [20.967, 11.495], [23.461, 13.967], [24.819, 17.206]];  // lightening hole, 16 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
