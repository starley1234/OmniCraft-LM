$fn = 32;

// ----------------------------------------------------------------------
// Flat adaptor: hex_disc, 12 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 14;      // points of the closed outline

profile = [[0, 27.298], [2.773, 15.149], [5.6, 4.898], [21.769, 0], [34.231, 0], [50.4, 4.898], [53.227, 15.149], [56, 27.298], [53.227, 39.447], [50.4, 49.698], [34.231, 54.596], [21.769, 54.596], [5.6, 49.698], [2.773, 39.447]];  // single closed polygon, 14 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
