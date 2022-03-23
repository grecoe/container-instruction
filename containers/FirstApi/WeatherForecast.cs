using System;

namespace FirstApi
{
    public class Identity
    {
        public String Provider { get; set; }
        public String Token { get; set; }

        public Identity(string provider)
        {
            this.Provider = provider;
        }
    }

    public class WeatherForecast
    {
        public DateTime Date { get; set; }

        public int TemperatureC { get; set; }

        public int TemperatureF => 32 + (int)(TemperatureC / 0.5556);

        public string Summary { get; set; }
    }
}
