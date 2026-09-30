$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 11 teeth, 22 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 22;      // points of the closed outline

profile = [[48.086, 23.422], [53.303, 28.775], [46.532, 35.72], [48.027, 43.044], [38.576, 45.227], [35.874, 52.196], [26.743, 48.922], [20.703, 53.325], [14.791, 45.634], [7.329, 46.072], [6.514, 36.406], [0, 32.74], [4.54, 24.168], [1.042, 17.562], [9.496, 12.806], [10.124, 5.357], [19.808, 5.926], [24.363, 0], [32.202, 5.714], [39.238, 3.191], [42.744, 12.236], [50.027, 13.918]];  // single closed polygon, 22 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
