$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 6-point blunt, R45
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 6;             // number of points / teeth
r_out = 45;               // tip radius
r_in = 29.25;             // root radius
bore_r = 4;               // centre bore radius
plate_t = 8;              // plate thickness, Z (extrusion height)
bore_d = 8;               // centre bore diameter

profile = [[90, 38.971], [70.331, 53.596], [67.5, 77.942], [45, 68.221], [22.5, 77.942], [19.669, 53.596], [0, 38.971], [19.669, 24.346], [22.5, 0], [45, 9.721], [67.5, 0], [70.331, 24.346]];  // primary outline, 12 points, counter clockwise
void_1 = [[48.927, 39.734], [48.429, 41.031], [47.517, 42.08], [46.302, 42.753], [44.93, 42.971], [43.567, 42.705], [42.376, 41.99], [41.502, 40.91], [41.049, 39.597], [41.073, 38.208], [41.571, 36.911], [42.483, 35.863], [43.698, 35.189], [45.07, 34.972], [46.433, 35.237], [47.624, 35.952], [48.498, 37.032], [48.951, 38.345]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
