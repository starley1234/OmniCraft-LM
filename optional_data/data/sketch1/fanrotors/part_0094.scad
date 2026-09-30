$fn = 32;

// ----------------------------------------------------------------------
// Fan rotor section: 7 blades, 22 mm hub radius, 11 mm blades
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 21;      // points of the closed outline

profile = [[53.903, 27.018], [59.896, 41.709], [64.093, 43.029], [50.494, 45.802], [42.745, 59.647], [44.33, 63.752], [33.683, 54.849], [18.027, 57.422], [15.805, 61.221], [16.128, 47.345], [4.355, 36.71], [0, 37.341], [11.049, 28.943], [12.024, 13.106], [8.815, 10.095], [22.271, 13.498], [35.259, 4.386], [35.613, 0], [41.342, 12.641], [56.565, 17.115], [60.214, 14.657]];  // single closed polygon, 21 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
