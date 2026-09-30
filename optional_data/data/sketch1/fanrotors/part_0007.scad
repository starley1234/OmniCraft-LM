$fn = 32;

// ----------------------------------------------------------------------
// Fan rotor section: 7 blades, 12 mm hub radius, 8 mm blades
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 21;      // points of the closed outline

profile = [[31.427, 16.695], [35.838, 25.079], [38.778, 26.376], [29.568, 26.941], [25.763, 35.617], [26.583, 38.724], [20.398, 31.876], [11.243, 34.31], [9.325, 36.888], [10.823, 27.783], [3.212, 22.143], [0, 22.251], [8.053, 17.745], [7.717, 8.278], [5.63, 5.834], [14.173, 9.321], [21.366, 3.155], [21.975, 0], [24.576, 8.853], [33.881, 10.633], [36.728, 9.142]];  // single closed polygon, 21 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
