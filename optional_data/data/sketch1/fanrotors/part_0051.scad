$fn = 32;

// ----------------------------------------------------------------------
// Fan rotor section: 7 blades, 22 mm hub radius, 11 mm blades
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 21;      // points of the closed outline

profile = [[54.039, 26.896], [60.032, 41.587], [63.856, 43.997], [50.63, 45.68], [42.881, 59.525], [43.381, 64.017], [33.819, 54.727], [18.163, 57.301], [14.962, 60.492], [16.264, 47.224], [4.491, 36.588], [0, 36.076], [11.185, 28.821], [12.16, 12.985], [9.761, 9.154], [22.407, 13.376], [35.396, 4.264], [36.894, 0], [41.478, 12.519], [56.701, 16.993], [60.969, 15.507]];  // single closed polygon, 21 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
