$fn = 32;

// ----------------------------------------------------------------------
// Fan rotor section: 7 blades, 15 mm hub radius, 14 mm blades
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 21;      // points of the closed outline

profile = [[43.312, 24.789], [51.107, 36.01], [56.116, 38.664], [40.988, 37.596], [37.074, 50.687], [38.123, 56.258], [29.525, 43.764], [16.85, 48.867], [13.149, 53.16], [17.556, 38.648], [5.664, 31.92], [0, 31.703], [14.093, 26.101], [11.939, 12.609], [8.578, 8.045], [21.744, 15.57], [30.95, 5.474], [32.422, 0], [34.748, 14.986], [48.381, 15.888], [53.579, 13.627]];  // single closed polygon, 21 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
