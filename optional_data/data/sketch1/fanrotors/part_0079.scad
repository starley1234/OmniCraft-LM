$fn = 32;

// ----------------------------------------------------------------------
// Fan rotor section: 7 blades, 15 mm hub radius, 18 mm blades
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 21;      // points of the closed outline

profile = [[47.155, 28.88], [57.233, 40.843], [64.093, 43.029], [44.831, 41.688], [41.761, 57.026], [44.33, 63.752], [33.369, 47.856], [19.463, 55.019], [15.805, 61.221], [21.4, 42.74], [7.129, 36.334], [0, 37.341], [17.937, 30.192], [14.048, 15.041], [8.815, 10.095], [25.588, 19.662], [35.008, 7.175], [35.613, 0], [38.591, 19.078], [54.228, 18.658], [60.214, 14.657]];  // single closed polygon, 21 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
