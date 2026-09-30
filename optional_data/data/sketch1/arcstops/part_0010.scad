$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[31.16, 0], [30.461, 7.251], [28.393, 14.235], [22.829, 11.987], [21.186, 15.444], [19.142, 18.68], [16.726, 21.648], [13.972, 24.307], [10.921, 26.618], [7.616, 28.548], [4.104, 30.07], [0, 18.794], [4.343, 16.581], [8.022, 13.383], [10.819, 9.389], [12.566, 4.838], [13.16, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
