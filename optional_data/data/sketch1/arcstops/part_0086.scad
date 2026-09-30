$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[46, 0], [45.552, 6.402], [44.218, 12.679], [38.45, 11.025], [35.775, 17.893], [31.885, 24.152], [26.913, 29.592], [21.027, 34.027], [14.428, 37.307], [7.338, 39.321], [0, 40], [0, 32], [9.889, 30.434], [18.809, 25.889], [25.889, 18.809], [30.434, 9.889], [32, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
