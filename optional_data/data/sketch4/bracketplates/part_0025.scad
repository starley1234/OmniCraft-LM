$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: gusset 70 x 50
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 3.5;             // bolt hole radius
plate_t = 5;              // plate thickness, Z (extrusion height)
gus_a = 70;               // base length
gus_b = 50;               // height
top_x = 31.5;             // top edge X of the angled cut
light_r = 9;              // lightening hole radius

light_d = 2 * light_r;

profile = [[4, 0], [35, 0], [70, 0], [31.5, 50], [0, 50], [0, 4]];  // primary outline, 6 points, counter clockwise
void_1 = [[31.235, 20.717], [29.905, 23.967], [27.433, 26.461], [24.194, 27.819], [20.683, 27.835], [17.433, 26.505], [14.939, 24.033], [13.581, 20.794], [13.565, 17.283], [14.895, 14.033], [17.367, 11.539], [20.606, 10.181], [24.117, 10.165], [27.367, 11.495], [29.861, 13.967], [31.219, 17.206]];  // lightening hole, 16 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
