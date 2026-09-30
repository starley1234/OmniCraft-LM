$fn = 32;

// ----------------------------------------------------------------------
// Fan rotor section: 7 blades, 15 mm hub radius, 11 mm blades
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 21;      // points of the closed outline

profile = [[40.327, 21.812], [46.41, 32.477], [50.311, 34.664], [38.003, 34.619], [33.457, 46.025], [34.179, 50.438], [26.541, 40.787], [14.789, 44.345], [11.789, 47.66], [14.571, 35.671], [4.463, 28.702], [0, 28.423], [11.109, 23.124], [10.255, 10.875], [7.69, 7.212], [18.76, 12.593], [27.804, 4.289], [29.068, 0], [31.763, 12.009], [43.894, 13.903], [48.036, 12.217]];  // single closed polygon, 21 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
