$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 5-point star, R30
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 5;             // number of points / teeth
r_out = 30;               // tip radius
r_in = 16.5;              // root radius
bore_r = 4;               // centre bore radius
plate_t = 6;              // plate thickness, Z (extrusion height)
bore_d = 8;               // centre bore diameter

profile = [[0, 28.532], [16.651, 18.833], [20.729, 0], [35.099, 12.839], [54.271, 10.898], [46.5, 28.532], [54.271, 46.165], [35.099, 44.224], [20.729, 57.063], [16.651, 38.23]];  // primary outline, 10 points, counter clockwise
void_1 = [[33.927, 29.295], [33.429, 30.592], [32.517, 31.64], [31.302, 32.314], [29.93, 32.531], [28.567, 32.266], [27.376, 31.551], [26.502, 30.471], [26.049, 29.157], [26.073, 27.768], [26.571, 26.472], [27.483, 25.423], [28.698, 24.75], [30.07, 24.532], [31.433, 24.797], [32.624, 25.513], [33.498, 26.592], [33.951, 27.906]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
