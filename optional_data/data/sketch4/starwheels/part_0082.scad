$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 5-point blunt, R30
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 5;             // number of points / teeth
r_out = 30;               // tip radius
r_in = 19.5;              // root radius
bore_r = 4;               // centre bore radius
plate_t = 8;              // plate thickness, Z (extrusion height)
bore_d = 8;               // centre bore diameter

profile = [[54.271, 28.532], [40.046, 39.994], [33.541, 57.063], [18.245, 47.077], [0, 46.165], [4.771, 28.532], [0, 10.898], [18.245, 9.986], [33.541, 0], [40.046, 17.07]];  // primary outline, 10 points, counter clockwise
void_1 = [[28.197, 29.295], [27.699, 30.592], [26.788, 31.64], [25.573, 32.314], [24.201, 32.531], [22.837, 32.266], [21.646, 31.551], [20.772, 30.471], [20.32, 29.157], [20.344, 27.768], [20.842, 26.472], [21.753, 25.423], [22.968, 24.75], [24.34, 24.532], [25.704, 24.797], [26.895, 25.513], [27.769, 26.592], [28.221, 27.906]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
