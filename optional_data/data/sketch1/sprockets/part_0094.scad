$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 10 teeth, 26 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[59.502, 28.485], [67.807, 35.597], [57.288, 44.4], [59.826, 55.035], [46.142, 55.975], [41.944, 66.071], [30.321, 58.787], [20.991, 64.488], [15.868, 51.764], [4.97, 50.891], [8.305, 37.586], [0, 30.474], [10.519, 21.67], [7.98, 11.036], [21.665, 10.096], [25.862, 0], [37.486, 7.283], [46.816, 1.583], [51.938, 14.307], [62.837, 15.18]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
