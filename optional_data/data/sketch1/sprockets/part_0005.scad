$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 10 teeth, 22 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[47.365, 21.803], [51.41, 29.56], [45.492, 35.27], [44.205, 43.923], [36.06, 45.064], [29.934, 51.308], [22.674, 47.444], [14.047, 48.894], [10.445, 41.501], [2.613, 37.603], [4.045, 29.504], [0, 21.748], [5.918, 16.037], [7.205, 7.385], [15.349, 6.243], [21.476, 0], [28.736, 3.864], [37.363, 2.414], [40.965, 9.807], [48.796, 13.705]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
