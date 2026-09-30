$fn = 32;

// ----------------------------------------------------------------------
// Fan rotor section: 7 blades, 12 mm hub radius, 11 mm blades
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 21;      // points of the closed outline

profile = [[34.406, 19.679], [40.529, 28.619], [44.595, 30.332], [32.547, 29.924], [29.374, 40.285], [30.57, 44.533], [23.377, 34.859], [13.299, 38.838], [10.724, 42.422], [13.802, 30.766], [4.407, 25.368], [0, 25.589], [11.032, 20.728], [9.395, 10.017], [6.474, 6.709], [17.152, 12.304], [24.506, 4.346], [25.272, 0], [27.555, 11.837], [38.362, 12.624], [42.237, 10.513]];  // single closed polygon, 21 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
