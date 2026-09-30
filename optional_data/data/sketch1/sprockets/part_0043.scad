$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 10 teeth, 26 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[56.511, 25.57], [61.824, 32.456], [54.296, 41.486], [54.548, 50.179], [43.15, 53.06], [38.243, 60.241], [27.329, 55.873], [19.139, 58.798], [12.877, 48.849], [4.531, 46.401], [5.313, 34.671], [0, 27.785], [7.527, 18.756], [7.276, 10.062], [18.674, 7.181], [23.58, 0], [34.494, 4.369], [42.685, 1.443], [48.947, 11.393], [57.293, 13.84]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
