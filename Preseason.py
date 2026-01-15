# %%
from nba_api.stats.endpoints import leaguedashplayerstats
import pandas as pd
import time

# %%
START_YEAR = 2003
END_YEAR = 2025
def season_string(year):
    return f"{year}-{str(year + 1)[-2:]}"

# %%
all_seasons = []
failed_seasons = []
for year in range(START_YEAR, END_YEAR):
    season = season_string(year)
    print(f"Fetching season: {season}")

    try:
        stats = leaguedashplayerstats.LeagueDashPlayerStats(
            season=season,
            season_type_all_star="Pre Season"
        )

        df = stats.get_data_frames()[0]
        df["SEASON"] = season

        all_seasons.append(df)

        # polite rate limiting
        time.sleep(1)

    except Exception as e:
        print(f"❌ Failed for season {season}: {e}")
        failed_seasons.append(season)
        time.sleep(2)

# %%
final_df = pd.concat(all_seasons, ignore_index=True)
print(final_df.shape)
print(final_df["SEASON"].nunique())
print(final_df.isna().sum().sort_values(ascending=False).head(10))

# %%
final_df.to_csv(
    r"/Users/sai/nba-players/datasets/preseason_raw.csv",
    index=False
)

# %%
df = pd.read_csv("/Users/sai/nba-players/datasets/preseason_raw.csv")
print(df.shape)
print(df["SEASON"].unique())

# %%



