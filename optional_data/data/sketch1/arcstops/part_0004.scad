$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 12 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[59.681, 0], [58.836, 8.777], [56.331, 17.232], [50.768, 14.984], [46.618, 22.697], [40.888, 29.322], [33.853, 34.541], [25.852, 38.103], [17.266, 39.839], [8.509, 39.664], [0, 37.588], [2.736, 30.07], [14.798, 31.981], [26.696, 29.233], [36.7, 22.229], [43.351, 11.987], [45.681, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
