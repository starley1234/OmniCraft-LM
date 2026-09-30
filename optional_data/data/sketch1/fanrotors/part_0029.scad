$fn = 32;

// ----------------------------------------------------------------------
// Fan rotor section: 7 blades, 15 mm hub radius, 11 mm blades
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 21;      // points of the closed outline

profile = [[40.22, 21.908], [46.303, 32.573], [50.498, 33.902], [37.896, 34.715], [33.35, 46.121], [34.926, 50.229], [26.433, 40.883], [14.682, 44.441], [12.453, 48.234], [14.464, 35.767], [4.356, 28.798], [0, 29.42], [11.001, 23.22], [10.148, 10.971], [6.945, 7.954], [18.652, 12.689], [27.697, 4.385], [28.059, 0], [31.656, 12.105], [43.787, 13.999], [47.441, 11.548]];  // single closed polygon, 21 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
