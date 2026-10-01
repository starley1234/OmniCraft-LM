$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 6-point star, R45
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 6;             // number of points / teeth
r_out = 45;               // tip radius
r_in = 24.75;             // root radius
bore_r = 4;               // centre bore radius
plate_t = 6;              // plate thickness, Z (extrusion height)
bore_d = 8;               // centre bore diameter

profile = [[38.971, 90], [26.596, 66.434], [0, 67.5], [14.221, 45], [0, 22.5], [26.596, 23.566], [38.971, 0], [51.346, 23.566], [77.942, 22.5], [63.721, 45], [77.942, 67.5], [51.346, 66.434]];  // primary outline, 12 points, counter clockwise
void_1 = [[42.898, 45.763], [42.4, 47.06], [41.488, 48.109], [40.273, 48.782], [38.901, 48.999], [37.538, 48.734], [36.347, 48.019], [35.473, 46.939], [35.02, 45.626], [35.045, 44.237], [35.542, 42.94], [36.454, 41.891], [37.669, 41.218], [39.041, 41.001], [40.405, 41.266], [41.595, 41.981], [42.47, 43.061], [42.922, 44.374]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
