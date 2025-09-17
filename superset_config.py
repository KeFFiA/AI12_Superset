# superset_config.py

import os


SECRET_KEY = os.getenv('SECRET_KEY')

# --- Main DB ---
SQLALCHEMY_DATABASE_URI = os.getenv("MAIN_DB_URL", "postgresql+psycopg2://superset:superset@212.69.84.131:5432/superset")

# --- Mapbox ---
MAPBOX_API_KEY = os.getenv("MAPBOX_API_KEY", "")

# --- CORS ---
ENABLE_CORS = True
CORS_OPTIONS = {
    "origins": ["*"],
    # Allow cookies if needed:
    "supports_credentials": True,
}

# --- Embedding (iframe) ---
FEATURE_FLAGS = {
    "EMBEDDED_SUPERSET": True,
    "ALERT_REPORTS": True
}
# Guest (public) role
GUEST_ROLE_NAME = "Public"
# guest token live time (if JWT guest tokens needed)
GUEST_TOKEN_JWT_EXP_SECONDS = int(os.getenv("GUEST_TOKEN_JWT_EXP_SECONDS", 300))

# --- Row-level ---
# RLS managing through UI: Security -> Row level security filters

ROW_LEVEL_SECURITY = True

# --- Cache / Results backend (Redis example) ---
# If Redis needed, write REDIS URL into .env:
REDIS_URL = os.getenv("REDIS_URL", "redis://redis:6379/0")

# Flask caching
CACHE_CONFIG = {
    "CACHE_TYPE": "RedisCache",
    "CACHE_DEFAULT_TIMEOUT": 60 * 60 * 24,  # 1 day default
    "CACHE_KEY_PREFIX": "superset_",
    "CACHE_REDIS_URL": REDIS_URL,
}

# Results backend (as example using redis)
RESULTS_BACKEND = {
    "class": "superset.utils.memoized_db.create_results_backend",
    "config": {
        "url": REDIS_URL,
    }
}

# --- Security ---
# COOKIE_SECURE = True   # HTTPS
# SESSION_COOKIE_SAMESITE = "Lax"  # if needed
