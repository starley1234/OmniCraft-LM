$fn = 32;

// ----------------------------------------------------------------------
// Fan rotor section: 7 blades, 18 mm hub radius, 14 mm blades
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 21;      // points of the closed outline

profile = [[49.056, 27.086], [56.813, 40.033], [62.151, 41.725], [46.267, 42.455], [40.981, 56.591], [42.986, 61.82], [32.513, 49.857], [18.164, 54.538], [15.326, 59.366], [18.15, 43.718], [5.544, 35.418], [0, 36.21], [13.994, 28.661], [12.623, 13.631], [8.548, 9.79], [23.175, 16.024], [34.071, 5.581], [34.534, 0], [38.779, 15.323], [53.738, 17.331], [58.389, 14.213]];  // single closed polygon, 21 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
