$fn = 32;

// ----------------------------------------------------------------------
// Cam disc: base radius 17.0 mm, lift 6.0 mm, 22 profile points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 22;      // points of the closed outline

profile = [[44.5, 18.042], [41.665, 23.523], [38.818, 28.208], [36.364, 33.466], [32.099, 37.967], [26.253, 40.67], [19.727, 40.808], [13.445, 38.964], [7.938, 35.425], [3.651, 30.477], [0.932, 24.522], [0, 18.042], [0.932, 11.562], [4.012, 5.84], [9.021, 1.91], [14.794, 0.073], [20.406, 0], [25.448, 1.019], [30.062, 2.579], [34.133, 5.195], [37.301, 8.851], [41.163, 12.709]];  // single closed polygon, 22 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
