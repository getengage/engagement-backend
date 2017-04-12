package models

import (
	"encoding/json"
	"os"

	"github.com/ip2location/ip2location-go"
)

type EventsRaw struct {
	APIKeyID             string  `json:"api_key_id"`
	Bottom               float64 `json:"bottom,string"`
	Count                int     `json:"count,string"`
	CreatedAt            string  `json:"created_at"`
	ID                   string  `json:"id"`
	InViewport           bool    `json:"in_viewport"`
	InViewportAndVisible float64
	InViewportArr        string `json:"in_viewport_arr"`
	IP2                  ip2location.IP2Locationrecord
	IsVisible            bool   `json:"is_visible"`
	IsVisibleArr         string `json:"is_visible_arr"`
	ReachedEnd           bool
	Referrer             string `json:"referrer"`
	RemoteIP             string `json:"remote_ip"`
	Scroll               struct {
		Q1 float64 // top quadrant
		Q2 float64
		Q3 float64
		Q4 float64 // bottom quadrant
	}
	SessionID string  `json:"session_id"`
	SourceURL string  `json:"source_url"`
	Tags      string  `json:"tags_arr"`
	Timestamp string  `json:"timestamp"`
	Top       float64 `json:"top,string"`
	UserAgent string  `json:"user_agent"`
	WordCount float64 `json:"word_count,string"`
	XPos      float64 `json:"x_pos,string"`
	XPosArr   string  `json:"x_pos_arr"`
	YPos      float64 `json:"y_pos,string"`
	YPosArr   string  `json:"y_pos_arr"`
}

func (e *EventsRaw) SetIP2() {
	pwd, _ := os.Getwd()
	ip2location.Open(pwd + "/lib/ip2location/IP2LOCATION-LITE-DB3.BIN")
	e.IP2 = ip2location.Get_all(e.RemoteIP)
}

func (e *EventsRaw) CheckScroll(pos float64) {
	quartile := e.Bottom / 4.0

	if pos <= quartile {
		e.Scroll.Q1++
	} else if pos <= quartile*2.0 {
		e.Scroll.Q2++
	} else if pos <= quartile*3.0 {
		e.Scroll.Q3++
	} else {
		e.Scroll.Q4++
	}
}

func (e *EventsRaw) XPositions() (xs []float64) {
	json.Unmarshal([]byte(e.XPosArr), &xs)
	return
}

func (e *EventsRaw) YPositions() (xy []float64) {
	json.Unmarshal([]byte(e.YPosArr), &xy)
	return
}

func (e *EventsRaw) Visible() (v []bool) {
	json.Unmarshal([]byte(e.IsVisibleArr), &v)
	return
}

func (e *EventsRaw) Viewport() (v []bool) {
	json.Unmarshal([]byte(e.InViewportArr), &v)
	return
}
