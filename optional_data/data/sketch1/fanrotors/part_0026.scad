$fn = 32;

// ----------------------------------------------------------------------
// Fan rotor section: 7 blades, 15 mm hub radius, 18 mm blades
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 21;      // points of the closed outline

profile = [[47.228, 28.824], [57.306, 40.788], [63.984, 43.52], [44.904, 41.632], [41.834, 56.97], [43.862, 63.895], [33.442, 47.8], [19.536, 54.963], [15.386, 60.866], [21.473, 42.684], [7.202, 36.278], [0, 36.714], [18.01, 30.137], [14.121, 14.985], [9.289, 9.626], [25.661, 19.606], [35.082, 7.119], [36.259, 0], [38.664, 19.022], [54.301, 18.602], [60.601, 15.084]];  // single closed polygon, 21 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
