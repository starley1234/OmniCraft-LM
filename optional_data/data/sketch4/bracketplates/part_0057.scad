$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: gusset 50 x 60
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 3.5;             // bolt hole radius
plate_t = 8;              // plate thickness, Z (extrusion height)
gus_a = 50;               // base length
gus_b = 60;               // height
top_x = 22.5;             // top edge X of the angled cut
light_r = 9;              // lightening hole radius

light_d = 2 * light_r;

profile = [[4, 0], [25, 0], [50, 0], [22.5, 60], [0, 60], [0, 4]];  // primary outline, 6 points, counter clockwise
void_1 = [[24.835, 24.517], [23.505, 27.767], [21.033, 30.261], [17.794, 31.619], [14.283, 31.635], [11.033, 30.305], [8.539, 27.833], [7.181, 24.594], [7.165, 21.083], [8.495, 17.833], [10.967, 15.339], [14.206, 13.981], [17.717, 13.965], [20.967, 15.295], [23.461, 17.767], [24.819, 21.006]];  // lightening hole, 16 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
