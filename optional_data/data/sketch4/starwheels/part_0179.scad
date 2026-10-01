$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 7-point blunt, R45
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 7;             // number of points / teeth
r_out = 45;               // tip radius
r_in = 27;                // root radius
bore_r = 4;               // centre bore radius
plate_t = 8;              // plate thickness, Z (extrusion height)
bore_d = 8;               // centre bore diameter

profile = [[43.872, 85.544], [32.157, 64.87], [8.689, 68.601], [17.549, 46.552], [0, 30.53], [22.762, 23.709], [24.347, 0], [43.872, 13.544], [63.397, 0], [64.981, 23.709], [87.744, 30.53], [70.195, 46.552], [79.054, 68.601], [55.587, 64.87]];  // primary outline, 14 points, counter clockwise
void_1 = [[47.798, 41.307], [47.3, 42.604], [46.389, 43.652], [45.174, 44.326], [43.802, 44.543], [42.438, 44.278], [41.248, 43.562], [40.373, 42.483], [39.921, 41.169], [39.945, 39.78], [40.443, 38.483], [41.354, 37.435], [42.569, 36.762], [43.942, 36.544], [45.305, 36.809], [46.496, 37.525], [47.37, 38.604], [47.823, 39.918]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
