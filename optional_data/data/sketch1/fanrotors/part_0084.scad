$fn = 32;

// ----------------------------------------------------------------------
// Fan rotor section: 8 blades, 15 mm hub radius, 8 mm blades
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[36.46, 18.373], [40.931, 27.249], [43.749, 28.982], [34.664, 29.712], [31.549, 39.15], [32.316, 42.367], [25.376, 36.46], [16.5, 40.931], [14.767, 43.749], [14.037, 34.664], [4.599, 31.549], [1.381, 32.316], [7.289, 25.376], [2.818, 16.5], [0, 14.767], [9.085, 14.037], [12.2, 4.599], [11.433, 1.381], [18.373, 7.289], [27.249, 2.818], [28.982, 0], [29.712, 9.085], [39.15, 12.2], [42.367, 11.433]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
