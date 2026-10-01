$fn = 32;

// ----------------------------------------------------------------------
// Revolved part: V-groove pulley R30
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 5;               // bore radius
rim_r = 30;               // rim radius
rim_t = 10;               // rim width
groove_r = 11;            // groove root radius
groove_w = 4;             // groove half width
revolve_angle = 360;      // revolve sweep, degrees

bore_d = 2 * bore_r;
rim_d = 2 * rim_r;
groove_d = 2 * groove_r;

profile = [[5, 0], [30, 0], [30, 1], [11, 5], [30, 9], [30, 10], [5, 10]];  // primary outline, 7 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
